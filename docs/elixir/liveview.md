# Phoenix LiveView

## TL;DR;

Phoenix LiveView enables rich, real-time user experiences with server-rendered HTML.

### Features

Render HTML on the server over WebSockets with optional LongPolling fallback.

Support for function components, slots, HTML validation.

Sends only what changed to the client.

Rich integration API with the client with phx-click, phx-focus, phx-blur, phx-submit, etc.

Code reuse via stateful components.

Testing tools.

### What makes LiveView unique?

LiveView is server-centric. You no longer have to worry about managing both client and server to
keep things in sync.

LiveView automatically updates the client as changes happen on the server.

First rendered statically as part of regular HTTP requests, helping search and indexing engines.

There is less work to be done and less data to be sent compared to stateless requests that have to
authenticate, decode, load, and encode data on every request.

LiveView applications are distributed and real-time, with no extra external dependencies (no extra
databases, no extra message queues, etc).

### Browser Support

All current Chrome, Safari, Firefox, and MS Edge are supported. IE11 support is available with the
following polyfills.

## Server-side features

### Assigns and HEEx templates

All of the data in a LiveView is stored in the socket as assigns.

Those values can be accessed in the LiveView as `socket.assigns.name` but they are accessed inside
LiveView templates as `@name`.

Phoenix template language is called HEEx (HTML+EEx).

### Change tracking

When you first render a `.heex` template, it will send all of the static and dynamic parts of the
template to the client.

The tracking of changes is done via assigns.

The assign tracking feature also implies that you MUST avoid performing direct operations in the
template.

Generally speaking, data loading should never happen inside the template, regardless if you are
using LiveView or not. The difference is that LiveView enforces this best practice.

### Pitfalls

If the do/end block is given to a library function or user function, such as `content_tag`, change
tracking won't work.

LiveView has to disable change tracking whenever variables are used in the template.

Similarly, do not define variables at the top of your `render` function.

Generally speaking, avoid accessing variables inside LiveViews, as code that access variables is
always executed on every render.

To sum up:

1. Avoid passing block expressions to library and custom functions, instead prefer to use the
  conveniences in HEEx templates
2. Avoid defining local variables, except within Elixir's constructs

### Error and exception handling

####  Exceptions on mount

##### Exceptions during disconnected render

1. An exception on mount is caught and converted to an exception page by Phoenix error views - pretty
much like the way it works with controllers.

##### Exceptions during connected render

1. An exception on mount will crash the LiveView process - which will be logged
2. Once the client has noticed the crash during mount, it will fully reload the page
3. Reloading the page will start a disconnected render, that will cause mount to be invoked again
   and most likely raise the same exception. Except this time it will be caught and converted to
   an exception page by Phoenix error views

#### Exceptions on events (handle_info, handle_event, etc)

If the error happens during an event, the LiveView process will crash. The client will notice the
error and remount the LiveView - without reloading the page.

When the exception raises, the client will remount the LiveView. In other words, by remounting, we
often update the state of the page, allowing exceptions to be automatically handled.

### Live layouts

When working with LiveViews, there are usually three layouts to be considered:

- the root layout - this is a layout used by both LiveView and regular views.
- the app layout - this is the default application layout which is not included or used by
  LiveViews.
- the live layout - this is the layout which wraps a LiveView and is rendered as part of the
  LiveView life-cycle.

All layouts must call <%= @inner_content %> to inject the content rendered by the layout.

The "root" layout is shared by both "app" and "live" layouts.

The "app" and "live" layouts are often small and similar to each other, but the "app" layout uses
the `@conn` and is used as part of the regular request life-cycle. The "live" layout is part of
the LiveView and therefore has direct access to the `@socket`.

####  Updating the HTML document title

Because the root layout from the Plug pipeline is rendered outside of LiveView, the contents
cannot be dynamically changed.

Phoenix LiveView special cases the `@page_title` assign to allow dynamically updating the title of
the page.

If you find yourself needing to dynamically patch other parts of the base layout, such as
injecting new scripts or styles into the `<head>` during live navigation, then a regular, non-live,
page navigation should be used instead.

### Live navigation

LiveView provides functionality to allow page navigation using the browser's pushState API.

You can trigger live navigation in two ways:

- From the client - this is done by replacing `Phoenix.HTML.Link.link/2` by
  `Phoenix.LiveView.Helpers.live_patch/2` or `Phoenix.LiveView.Helpers.live_redirect/2`.
- From the server - this is done by replacing `Phoenix.Controller.redirect/2` calls by
  `Phoenix.LiveView.push_patch/2` or `Phoenix.LiveView.push_redirect/2`.


The "patch" operations must be used when you want to navigate to the current LiveView, simply
updating the URL and the current parameters, without mounting a new LiveView. When patch is used,
the `handle_params/3` callback is invoked and the minimal set of changes are sent to the client.

The "redirect" operations must be used when you want to dismount the current LiveView and mount a
new one. In those cases, an Ajax request is made to fetch the necessary information about the new
LiveView, which is mounted in place of the current one within the current layout. While
redirecting, a `phx-loading` class is added to the LiveView, which can be used to indicate to the
user a new page is being loaded.

At the end of the day, the user will end-up on the same page. The difference between those is
mostly the amount of data sent over the wire:

- `link/2` and `redirect/2` do full page reloads.
- `live_redirect/2` and `push_redirect/2` mounts a new LiveView while keeping the current layout.
- `live_patch/2` and `push_patch/2` updates the current LiveView and sends only the minimal diff
  while also maintaining the scroll position.

An easy rule of thumb is to stick with `live_redirect/2` and `push_redirect/2` and use the patch
helpers only in the cases where you want to minimize the amount of data sent when navigating
within the same LiveView (for example, if you want to change the sorting of a table while also
updating the URL).


#### handle_params/3

The `handle_params/3` callback is invoked after `mount/3` and before the initial render. It is
also invoked every time `live_patch/2` or `push_patch/2` are used.

Note we returned `{:noreply, socket}`, where `:noreply` means no additional information is sent to
the client.

Changes to the state inside `handle_params/3` will trigger a new server render.

Data should always be loaded on `mount/3`, since `mount/3` is invoked once per LiveView
life-cycle. Only the params you expect to be changed via `live_patch/2` or `push_patch/2` must be
loaded on `handle_params/3`.

It is very important to not access the same parameters on both `mount/3` and `handle_params/3`.

Once a parameter is read on mount, it should not be read elsewhere.

#### Replace page address

LiveView also allows the current browser URL to be replaced, without polluting the browser's
history.

### Security considerations of the LiveView model

Both the HTTP request and the stateful connection receive the client data via parameters and
session.

This means that any session validation must happen both in the HTTP request (plug pipeline) and
the stateful connection (LiveView mount).

#### Authentication vs authorization

In a regular web application, we perform authentication and authorization checks on every
request. In LiveView, we should also run those exact same checks, always. Once the user is
authenticated, we typically validate the sessions on the `mount` callback. Authorization rules
generally happen on `mount` (for instance, is the user allowed to see this page?) and also on
`handle_event` (is the user allowed to delete this item?).

#### Mounting considerations

LiveView v0.17 includes the `on_mount` (`Phoenix.LiveView.on_mount/1`) hook, which allows you to
encapsulate this logic and execute it on every mount, as you would with plug.

#### Events considerations

Every time the user performs an action on your system, you should verify if the user is authorized
to do so, regardless if you are using LiveViews or not.

#### Disconnecting all instances of a live user

Because LiveView is a permanent connection between client and server, if a user is logged out, or
removed from the system, this change won't reflect on the LiveView part unless the user reloads
the page.

It is possible to address this by setting a live_socket_id in the session.

Once a LiveView is disconnected, the client will attempt to reestablish the connection and
re-execute the `mount/3` callback.

#### `live_session` and `live_redirect`

If you want to draw stronger boundaries between parts of your application, you can also use
`Phoenix.LiveView.Router.live_session/2` to group your live routes. This can be handy because you
can only `live_redirect` between LiveViews in the same `live_session`.

For example, imagine you need to authenticate two distinct types of users.

You can specify different `live_sessions` for each authentication flow.

`live_session` can also be used to enforce each LiveView group has a different root layout.

You can even combine `live_session` with `on_mount`. Instead of declaring on_mount on every
LiveView, you can declare it at the router level and it will enforce it on all LiveViews under it.

The important concepts to keep in mind are:

- If you have both LiveViews and regular web requests, then you must always authorize and
  authenticate your LiveViews (using on mount hooks) and your web requests (using plugs).
- All actions (events) must also be explicitly authorized by checking permissions.
- `live_session` can be used to draw boundaries between groups of LiveViews.

### Telemetry

LiveView currently exposes the following telemetry events:

- [:phoenix, :live_view, :mount, :start]
- [:phoenix, :live_view, :mount, :stop]
- [:phoenix, :live_view, :mount, :exception]

- [:phoenix, :live_view, :handle_params, :start]
- [:phoenix, :live_view, :handle_params, :stop]
- [:phoenix, :live_view, :handle_params, :exception]

- [:phoenix, :live_view, :handle_event, :start]
- [:phoenix, :live_view, :handle_event, :stop]
- [:phoenix, :live_view, :handle_event, :exception]

- [:phoenix, :live_component, :handle_event, :start]
- [:phoenix, :live_component, :handle_event, :stop]
- [:phoenix, :live_component, :handle_event, :exception]

### Uploads

#### Built-in Features

LiveView supports interactive file uploads with progress for both direct to server uploads as well
as direct-to-cloud external uploads on the client.

When the client selects file(s), the file metadata is automatically validated against the
specification.

Uploads are populated in an @uploads assign in the socket. Entries automatically respond to
progress, errors, cancellation, etc.

Drag and drop - Use the `phx-drop-target` attribute to enable.

#### Allow uploads

You enable an upload, typically on mount, via `allow_upload/3`

#### Entry validation

Validation occurs automatically based on any conditions that were specified in `allow_upload/3`
however, as mentioned previously you are required to bind `phx-change` on the form in order for
the validation to be performed. Therefore you must implement at least a minimal callback.

#### Cancel an entry

Upload entries may also be canceled, either programmatically or as a result of a user action.

####  Consume uploaded entries

When the end-user submits a form containing a `live_file_input/2`, the JavaScript client first
uploads the file(s) before invoking the callback for the form's `phx-submit` event.

You invoke the `Phoenix.LiveView.consume_uploaded_entries/3` function to process the completed
uploads.

### Using Gettext for internationalization

For internationalization with gettext, the locale used within your Plug pipeline can be stored in
the Plug session and restored within your LiveView mount.

You can also use the `on_mount` (`Phoenix.LiveView.on_mount/1`) hook to automatically restore the
locale for every LiveView in your application.

## Client-side integration

### Bindings

Phoenix supports DOM element bindings for client-server interaction.

Then on the server, all LiveView bindings are handled with the handle_event callback.

#### Click Events

The `phx-click` binding is used to send click events to the server.

If the phx-value- prefix is used, the server payload will also contain a "value".

The payload will also include any additional user defined metadata of the client event.

The `phx-click-away` event is fired when a click event happens outside of the element.

#### Focus and Blur Events

Focus and blur events may be bound to DOM elements that emit such events.

To detect when the page itself has received focus or blur, `phx-window-focus` and `phx-window-blur`
may be specified.

`phx-value-*` can be provided on the bound element, and those values will be sent as part of the
payload.

#### Key Events

The `onkeydown`, and `onkeyup` events are supported via the `phx-keydown`, and `phx-keyup`
bindings. Each binding supports a `phx-key` attribute, which triggers the event for the specific
key press. If no `phx-key` is provided, the event is triggered for any key press. When pushed, the
value sent to the server will contain the `"key"` that was pressed, plus any user-defined metadata.

It is possible for certain browser features like autofill to trigger key events with no `"key"`
field present in the value map sent to the server. For this reason, we recommend always having a
fallback catch-all event handler for LiveView key bindings.

####  Rate limiting events with Debounce and Throttle

`phx-debounce` - Accepts either an integer timeout value (in milliseconds), or `"blur"`.

`phx-throttle` - Accepts an integer timeout value to throttle the event in milliseconds. Unlike
debounce, throttle will immediately emit the event, then rate limit it at once per provided
timeout.

####  Debounce and Throttle special behavior

When a `phx-submit`, or a `phx-change` for a different input is triggered, any current debounce or
throttle timers are reset for existing inputs.

A `phx-keydown` binding is only throttled for key repeats. Unique keypresses back-to-back will
dispatch the pressed key events.

#### JS Commands

LiveView bindings support a JavaScript command interface via the `Phoenix.LiveView.JS` module.

The `Phoenix.LiveView.JS.push/3` command is particularly powerful in allowing you to customize the
event being pushed to the server.

####  LiveView Specific Events

The `lv:` event prefix supports LiveView specific features that are handled by LiveView without
calling the user's `handle_event/3` callbacks.

`lv:clear-flash` – clears the flash when sent to the server.

####  Loading states and errors

All `phx-` event bindings apply their own css classes when pushed.

On click, would receive the `phx-click-loading` class, and on keydown would receive the
`phx-keydown-loading` class. The css loading classes are maintained until an acknowledgement is
received on the client for the pushed event.

In the case of forms, when a `phx-change` is sent to the server, the input element which emitted
the change receives the `phx-change-loading` class, along with the parent form tag.

### Form bindings

#### A note about form helpers

LiveView works with the existing Phoenix.HTML form helpers.

Using the generated `:live_view` and `:live_component` helpers will also import
`MyAppWeb.ErrorHelpers`. You are welcome to change the ErrorHelpers module as you prefer.

#### Form Events

To handle form changes and submissions, use the `phx-change` and `phx-submit` events.

The validate callback simply updates the changeset based on all form input values, then assigns
the new changeset to the socket. If the changeset changes, such as generating new errors,
`render/1` is invoked and the form is re-rendered.

Likewise for `phx-submit` bindings, the same callback is invoked and persistence is attempted. On
success, a `:noreply` tuple is returned and the socket is annotated for redirect with
`Phoenix.LiveView.redirect/2`

#### `phx-feedback-for`

For proper form error tag updates, the error tag must specify which input it belongs to. This is
accomplished with the `phx-feedback-for` attribute, which specifies the name (or id, for backwards
compatibility) of the input it belongs to. Failing to add the `phx-feedback-for` attribute will
result in displaying error messages for form fields that the user has not changed yet
(e.g. required fields further down on the page).

#### Number inputs

Number inputs are a special case in LiveView forms.

LiveView will not send change events from the client when an input is invalid, instead allowing
the browser's native validation UI to drive user interaction. Once the input becomes valid, change
and submit events will be sent normally.

One alternative is the inputmode attribute.

#### Password inputs

For security reasons, password field values are not reused when rendering a password input
tag. This requires explicitly setting the `:value` in your markup.

#### Submitting the form action over HTTP

The `phx-trigger-action` attribute can be added to a form to trigger a standard form submit on DOM
patch to the URL specified in the form's standard `action` attribute. This is useful to perform
pre-final validation of a LiveView form submit before posting to a controller route for operations
that require Plug session mutation.

Once phx-trigger-action is true, LiveView disconnects and then submits the form.

#### Recovery following crashes or disconnects

By default, all forms marked with `phx-change` will recover input values automatically after the
user has reconnected or the LiveView has remounted after a crash.

If you want to see form recovery working in development, please make sure to disable live
reloading in development by commenting out the LiveReload plug in your `endpoint.ex` file or by
setting `code_reloader: false` in your `config/dev.exs`.

To enable specialized recovery, provide a `phx-auto-recover` binding on the form to specify a
different event to trigger for recovery.

#### JavaScript client specifics

The JavaScript client is always the source of truth for current input values. For any given input
with focus, LiveView will never overwrite the input's current value, even if it deviates from the
server's rendered updates.

To handle latent events, the `<button>` tag of a form can be annotated with `phx-disable-with`.

You may also take advantage of LiveView's CSS loading state classes to swap out your form content
while the form is submitting.

We strongly recommend including a unique HTML "id" attribute on the form. When DOM siblings
change, elements without an ID will be replaced rather than moved, which can cause issues such as
form fields losing focus.

### DOM patching & temporary assigns

A container can be marked with `phx-update`, allowing the DOM patch operations to avoid updating or
removing portions of the LiveView, or to append or prepend the updates rather than replacing the
existing contents.

The following `phx-update` values are supported:

- `replace` - the default operation. Replaces the element with the contents.
- `ignore` - ignores updates to the DOM regardless of new content changes.
- `append` - append the new DOM contents instead of replacing.
- `prepend` - prepend the new DOM contents instead of replacing.

When using `phx-update`, a unique DOM ID must always be set in the container. If using "append" or
"prepend", a DOM ID must also be set for each child. When appending or prepending elements
containing an ID already present in the container, LiveView will replace the existing element with
the new content instead appending or prepending a new element.

The "ignore" behaviour is frequently used when you need to integrate with another JS library.

The "append" and "prepend" feature is often used with "Temporary assigns" to work with large
amounts of data.

To react to elements being removed from the DOM, the `phx-remove` binding may be specified.

#### Temporary assigns

By default, all LiveView assigns are stateful. In some cases, it's useful to mark assigns as
temporary, meaning they will be reset to a default value after each update.

By using temporary assigns and phx-update, we don't need to keep any messages in memory, and send
messages to be appended to the UI only when there are new ones.

The first step is to mark which assigns are temporary and what values they should be reset to on
mount.

On mount we also load the initial number of messages we want to send. After the initial render,
the initial batch of messages will be reset back to an empty list.

When the client receives new messages, it now knows to append to the old content rather than
replace it.

LiveView uses DOM ids to check if a message is rendered before or not. If an id is rendered
before, the DOM element is updated rather than appending or prepending a new node. Also, the order
of elements is not changed.

### JavaScript interoperability

#### Debugging Client Events

To aid debugging on the client when troubleshooting issues, the `enableDebug()` and
`disableDebug()` functions are exposed on the `LiveSocket` JavaScript instance. Calling
`enableDebug()` turns on debug logging which includes LiveView life-cycle and payload events as
they come and go from client to server.

#### Simulating Latency

In development, near zero latency on localhost does not allow latency to be easily represented or
tested, so LiveView includes a latency simulator with the JavaScript client to ensure your
application provides a pleasant experience.

The `enableLatencySim` function accepts an integer in milliseconds for the round-trip-time to the
server.

####  Live navigation events

Form submits via `phx-submit`, the JavaScript events `"phx:page-loading-start"` and
`"phx:page-loading-stop"` are dispatched on window.

Within the callback, `info.detail` will be an object that contains a `kind` key, with a value that
depends on the triggering event:

- `"redirect"` - the event was triggered by a redirect
- `"patch"` - the event was triggered by a patch
- `"initial"` - the event was triggered by initial page load
- `"element"` - the event was triggered by a phx- bound element,

For all kinds of page loading events, all but `"element"` will receive an additional `to` key in
the info metadata pointing to the href associated with the page load.

#### Handling server-pushed events

When the server uses `Phoenix.LiveView.push_event/3`, the event name will be dispatched in the
browser with the `phx:` prefix.

#### External Uploads

Typically when your function is invoked, you will generate a pre-signed URL, specific to your
cloud storage provider, that will provide temporary access for the end-user to upload data
directly to your cloud storage.

## References

- https://github.com/phoenixframework/phoenix_live_view
- https://hexdocs.pm/phoenix_live_view/assigns-eex.html
