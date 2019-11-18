# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersSpreadsheet do
  let(:user) { create(:user).decorate }
  let(:users_spreadsheet) { UsersSpreadsheet.new([user]) }
  let(:header_attributes) do
    %w[
      name
      email
      level
      office
      role
      specialty
      occupation
      contract_type
      github
    ].map { |attribute| User.human_attribute_name(attribute) }
  end
  let (:enumerize_attributes) do
    [
      user.occupation
    ].map { |attr| attr.nil? ? nil : attr.text }
  end
  let (:body_attributes) do
    [
      user.name,
      user.email,
      user.level,
      user.office.city,
      user.role,
      user.specialty,
      user.contract_type,
      user.github
    ].concat(enumerize_attributes)
  end

  describe '#to_string_io' do
    subject do
      users_spreadsheet
        .to_string_io
        .force_encoding('iso-8859-1')
        .encode('utf-8')
    end

    it 'returns spreadsheet data' do
      is_expected.to include(*body_attributes)
    end

    it 'returns spreadsheet with header' do
      is_expected.to include(*header_attributes)
    end
  end

  describe '#generate_xls' do
    subject(:spreadsheet) { users_spreadsheet.generate_xls }

    it 'returns spreadsheet object with header' do
      expect(spreadsheet.row(0)).to containing_exactly(*header_attributes)
    end

    it 'returns spreadsheet object with body' do
      expect(spreadsheet.row(1)).to containing_exactly(*body_attributes)
    end
  end

  describe '#body' do
    subject { users_spreadsheet.body(user) }

    it 'return body data' do
      is_expected.to containing_exactly(*body_attributes)
    end
  end

  describe '#header' do
    subject { users_spreadsheet.header }

    it 'returns header data' do
      is_expected.to containing_exactly(*header_attributes)
    end
  end
end
