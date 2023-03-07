module SamplesHelper
  def sample_header_need?
    Sample::SAMPLE_HEADER_NEED.include?(controller_path)
  end
end
