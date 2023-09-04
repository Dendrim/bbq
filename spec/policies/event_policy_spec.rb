require 'rails_helper'

RSpec.describe EventPolicy do
  subject { EventPolicy }

  let(:event_owner) { create(:user, name: 'event owner') }
  let(:event) { create(:event, user: event_owner) }

  let(:user_stranger) { create(:user, name: 'user stranger') }

  permissions :index? do
    it { is_expected.to permit(event_owner) }
    it { is_expected.to permit(nil) }
  end

  permissions :show? do
    it { is_expected.to permit(event_owner, event) }
    it { is_expected.to permit(user_stranger, event) }
    it { is_expected.to permit(nil, event) }
  end

  permissions :new? do
    it { is_expected.to permit(event_owner) }
    it { is_expected.not_to permit(nil) }
  end

  permissions :create? do
    it { is_expected.to permit(event_owner) }
    it { is_expected.not_to permit(nil) }
  end

  permissions :update? do
    it { is_expected.to permit(event_owner, event) }
    it { is_expected.not_to permit(user_stranger, event) }
    it { is_expected.not_to permit(nil, event) }
  end

  permissions :edit? do
    it { is_expected.to permit(event_owner, event) }
    it { is_expected.not_to permit(user_stranger, event) }
    it { is_expected.not_to permit(nil, event) }
  end

  permissions :destroy? do
    it { is_expected.to permit(event_owner, event) }
    it { is_expected.not_to permit(user_stranger, event) }
    it { is_expected.not_to permit(nil, event) }
  end
end
