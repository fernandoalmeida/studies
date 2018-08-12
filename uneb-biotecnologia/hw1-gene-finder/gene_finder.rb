# https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=64320
# https://www.ncbi.nlm.nih.gov/genome/?term=txid64320[Organism:noexp]
# https://www.ncbi.nlm.nih.gov/nuccore/NC_012532.1?report=fasta&from=107&to=10366
class GeneFinder
  def initialize(file:)
    @sequence = extract_sequence(File.read(file))
  end

  def orfs
    {
      1 => extract_orfs(frame1, :positive),
      2 => extract_orfs(frame2, :positive),
      3 => extract_orfs(frame3, :positive),
      -1 => extract_orfs(frame1n, :negative),
      -2 => extract_orfs(frame2n, :negative),
      -3 => extract_orfs(frame3n, :negative)
    }
  end

  def export
    File.open('orfs.csv', 'w') do |output|
      output.write("frame,beg,end,seq,size\n")

      mapping = orfs

      [1, 2, 3, -1, -2, -3].each do |frame|
        mapping[frame].each do |orf|
          output.write(
            "#{frame},#{orf[:beg]},#{orf[:end]},#{orf[:seq]},#{orf[:size]}\n"
          )
        end
      end

      output.close
    end
  end

  private

  attr_reader :sequence

  SPECIAL_CODONS = {
    positive: { start: 'ATG', stops: %w(TAA TAG TGA) },
    negative: { start: 'TAC', stops: %w(ATT ATC ACT) }
  }.freeze

  def extract_orfs(frame_sequence, direction)
    subsequences(frame_sequence, direction)
      .map { |subseq, index| orfs_from_subseq(subseq, index, direction) }
      .flatten
  end

  def subsequences(frame_sequence, direction)
    index = 0
    subseqs = []
    subseq = ''

    i = 0
    while i < frame_sequence.size
      codon = frame_sequence[i, 3]
      subseq << codon

      if SPECIAL_CODONS[direction][:stops].include?(codon)
        subseqs << [subseq, index]
        index = i + 3
        subseq = ''
      end

      i += 3
    end

    subseqs
  end

  def orfs_from_subseq(subseq, start_index, direction)
    orfs = []

    i = 0
    while i < subseq.size
      codon = subseq[i, 3]

      if codon == SPECIAL_CODONS[direction][:start]
        orfs << {
          beg: start_index + i + 1,
          end: start_index + subseq.size,
          seq: subseq[i, subseq.size],
          size: subseq.size - i
        }

        start_index = i + 3
      end

      i += 3
    end

    if start_index == 0 && orfs == []
      orfs << {
        beg: 1,
        end: subseq.size,
        seq: subseq,
        size: subseq.size
      }
    end

    orfs
  end

  def frame1
    sequence[0..-1]
  end

  def frame2
    sequence[1..-1]
  end

  def frame3
    sequence[2..-1]
  end

  def frame1n
    sequence.reverse[0..-1]
  end

  def frame2n
    sequence.reverse[1..-1]
  end

  def frame3n
    sequence.reverse[2..-1]
  end

  def extract_sequence(content)
    total_size = content.length
    first_line_size = content.index("\n") + 1
    index = first_line_size
    seq = ''

    while index < total_size
      if content[index] != "\n"
        seq << content[index]
      end
      index += 1
    end

    seq
  end
end
