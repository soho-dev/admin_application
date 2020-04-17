class Address < ApplicationRecord

  has_many :loan_applications

  def self.create_address(payload)
    payload = parsed_payload(payload)
    if payload["message"] == "address_eligible"
      formatted_address = payload["formatted_address"]
      address = Address.new
      address.street = formatted_address["street"]
      address.city = formatted_address["city"]
      address.zip = formatted_address["zip"]
      address.state = formatted_address["state"]
      address.county = formatted_address["county"]
      address
    else
      nil
    end
  end

  def self.parsed_payload(payload)
    JSON.parse(payload)
  end

  def to_hash
    {
      street: self.street,
      unit_number: self.unit_number,
      city: self.city,
      state: self.state,
      zip: self.zip,
      county: self.county
    }
  end

  def full_address
    self.street + ", " + self.state + ", " + self.county + " " + self.zip
  end
end
