defmodule InfoSys.Test.HTTPClient do
  @wolfram_xml File.read!(Path.expand('../fixtures/wolfram.xml', __DIR__))

  def request(url) do
    url = to_string(url)

    cond do
      String.contains?(url, "1+1") -> {:ok, {[], [], @wolfram_xml}}
      true -> {:ok, {[], [], "<queryresult></queryresult>"}}
    end
  end
end
