defmodule Mix.Tasks.UpdateSlackApi do
  @moduledoc """
  Updates Slack API documentation files for generating API code


  ## Updating docs

  You can update the docs by running the mix task like so:

    elixirc lib/mix/tasks/update_slack_api.exs
    mix update_slack_api


  While this works, the repo in question hasn't been updated in 5 years and does
  not appear to be properly mirrored or maintained anymore.

  """

  use Mix.Task
  @dir System.tmp_dir()

  @shortdoc "Updates Slack API documentation files for generating API code"
  def run(_) do
    try do
      System.cmd("git", [
        "clone",
        "https://github.com/slackhq/slack-api-docs",
        "#{@dir}/slack-api-docs"
      ])

      list_files()
      |> filter_json
      |> copy_files
    after
      System.cmd("rm", ["-rf", "#{@dir}/slack-api-docs"])
    end
  end

  defp list_files do
    File.ls!("#{@dir}slack-api-docs/methods")
  end

  defp filter_json(files) do
    Enum.filter(files, fn file ->
      String.ends_with?(file, "json")
    end)
  end

  defp copy_files(files) do
    File.mkdir_p!("lib/slack/web/docs")

    Enum.map(files, fn file ->
      origin = "#{@dir}slack-api-docs/methods/#{file}"
      dest = "lib/slack/web/docs/#{file}"
      File.cp!(origin, dest)
    end)
  end
end
