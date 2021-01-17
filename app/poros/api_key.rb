module ApiKey
  def self.generator
    SecureRandom.base64.tr('+/=', 'Qrt')
    # "I384fHtD1h9XZvs4fGPJUgtt"
  end
end
