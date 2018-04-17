describe "Zafira integration Spec" do
  describe "zafira enabled" do
    context "example failed" do
      it { expect(1).to eq(2) }
    end

    context "example passed" do
      it { expect(1).to eq(1) }
    end

    context "example skipped" do
      xit { expect(1).to eq(1) }
    end
  end
end
