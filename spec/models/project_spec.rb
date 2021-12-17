require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "shunya",
      last_name: "katada",
      email: "shunya.saitama@gmail.com",
      password: "password"
    )
    user.projects.create(
      name: "hogehoge"
    )
    new_project = user.projects.build(
      name: "hogehoge"
    )
    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken") 
  end

  it "allows two users to share a project name" do
    user = User.create(
      first_name: "shunya",
      last_name: "katada",
      email: "shunya.saitama@gmail.com",
      password: "password"
    )
    user.projects.build(
      name: "hogehoge"
    )
    other_user = User.create(
      first_name: "masayoshi",
      last_name: "ohishi",
      email: "ohishi@gmail.com",
      password: "password"
    )
    othre_project = other_user.projects.build(
      name: "hogehoge"
    )
    othre_project.valid?
    expect(othre_project).to be_valid
  end
end
