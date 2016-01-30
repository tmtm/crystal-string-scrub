require "./spec_helper"

describe "String" do
  describe "scrub" do
    it "returns new String same as original string" do
      "ABC日本語".scrub.should eq "ABC日本語"
    end

    it "returns replaced string if the string contains invalid byte" do
      "日本語".byte_slice(1, 6).scrub.should eq "??本?"
    end

    it "replaces the string with given char" do
      "日本語".byte_slice(1, 6).scrub('〓').should eq "〓〓本〓"
    end

    it "replaces the string with given string" do
      "日本語".byte_slice(1, 6).scrub("<invalid>").should eq "<invalid><invalid>本<invalid>"
    end
  end

  describe "valid_encoding?" do
    it "returns true if the string does not contains invalid byte" do
      "ABC日本語".valid_encoding?.should eq true
    end

    it "returns false if the string contains invalid byte" do
      "日本語".byte_slice(1, 6).valid_encoding?.should eq false
    end
  end
end
