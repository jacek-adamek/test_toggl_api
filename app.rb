#!/usr/bin/env ruby

require "dotenv"
require "togglv8"

module TogglV8
  class API
    # Gem doesn't provide it.
    def workspace_users(workspace_id)
      get "workspaces/#{workspace_id}/workspace_users"
    end
  end
end

Dotenv.load

toggl = TogglV8::API.new(ENV["TOGGL_API_TOKEN"])

toggl.workspaces.each do |workspace|
  puts
  puts "WORKSPACE:"
  puts workspace
  puts

  projects = toggl.projects(workspace["id"])
  projects.each do |project|
    puts "PROJECT:"
    puts project
    puts

    puts "PROJECT_USERS:"
    users = toggl.get_project_users(project["id"])
    users.each do |user|
      puts user
    end
  end

  puts
  puts "WORKSPACE_USERS:"
  puts toggl.workspace_users(workspace["id"])
end


# Interesting methods:

# create_project_user(params) params: [uid, pid]
# get_project_users(project_id)
# delete_project_user(project_user_id)

# projects(workspace_id, params={}) params: active
# users(workspace_id) returns 403!
