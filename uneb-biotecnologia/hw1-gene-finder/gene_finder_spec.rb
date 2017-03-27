require_relative 'gene_finder'

describe GeneFinder do
  describe '#frames' do
    it 'finds ORFs in the frame +1' do
      orfs = GeneFinder.new(file: 'sequence2.fasta').orfs

      frame1 = orfs[1]

      expect(frame1.size).to eq(42)
    end

    it 'finds ORFs in the frame +2' do
      orfs = GeneFinder.new(file: 'sequence2.fasta').orfs

      frame2 = orfs[2].sort_by { |orf| [orf[:size], orf[:beg]] }

      expect(frame2.size).to eq(130)
    end

    it 'finds ORFs in the frame +3' do
      orfs = GeneFinder.new(file: 'sequence2.fasta').orfs

      frame3 = orfs[3].sort_by { |orf| [orf[:size], orf[:beg]] }

      expect(frame3.size).to eq(99)
    end

    it 'finds ORFs in the frame -1' do
      orfs = GeneFinder.new(file: 'sequence2.fasta').orfs

      frame1n = orfs[-1].sort_by { |orf| [orf[:size], orf[:beg]] }

      expect(frame1n.size).to eq(136)
    end

    it 'finds ORFs in the frame -2' do
      orfs = GeneFinder.new(file: 'sequence2.fasta').orfs

      frame1n = orfs[-2].sort_by { |orf| [orf[:size], orf[:beg]] }

      expect(frame1n.size).to eq(52)
    end

    it 'finds ORFs in the frame -3' do
      orfs = GeneFinder.new(file: 'sequence2.fasta').orfs

      frame1n = orfs[-3].sort_by { |orf| [orf[:size], orf[:beg]] }

      expect(frame1n.size).to eq(36)
    end

    it 'generates an output file' do
      finder = GeneFinder.new(file: 'sequence2.fasta')

      expect { finder.export }.not_to raise_error

      lines = File.readlines('orfs.csv')

      expect(lines.first).to match('frame,beg,end,seq,size')
      expect(lines.size).to eq(496)
    end

    it 'finds the Zika virus genome' do
      orfs = GeneFinder.new(file: 'sequence2.fasta').orfs

      zika_virus_genome = orfs[2].detect { |orf| orf[:size] == 10_260 }

      expect(zika_virus_genome).to be_a(Hash) # exists

      expect(zika_virus_genome[:size]).to eq(10_260)
      expect(zika_virus_genome[:seq]).to match(/ATGAAAAACCCC.*GGAGTGTTGTAA/)
      expect(zika_virus_genome[:beg]).to eq(106) # 107
      expect(zika_virus_genome[:end]).to eq(10_365) # 10_336
    end
  end
end
