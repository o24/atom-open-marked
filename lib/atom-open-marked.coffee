{CompositeDisposable} = require 'atom'
{exec} = require 'child_process'

module.exports = AtomOpenMarked =
  subscriptions: null,
  config:
      OpenCommand:
          type: 'string'
          default: "Marked\ 2.app"

  activate: (state) ->
    @openCommand = atom.config.get "atom-open-marked.OpenCommand"
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-open-marked:OpenMarked': => @openMarked()

  deactivate: ->
    @subscriptions.dispose()

  openMarked: ->
    console.log "openMarked()"
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file
    path = file.path

    if path.indexOf(".md") isnt -1
      command = "open -a '#{@openCommand}' '#{path}'"
      console.log "command:" + command
      exec(command)
    else
      alert "Selected file is not .md"
