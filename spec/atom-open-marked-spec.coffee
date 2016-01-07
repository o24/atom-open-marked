AtomOpenMarked = require '../lib/atom-open-marked'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomOpenMarked", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-open-marked')

  describe "when the atom-open-marked:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.atom-open-marked')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'atom-open-marked:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.atom-open-marked')).toExist()

        atomOpenMarkedElement = workspaceElement.querySelector('.atom-open-marked')
        expect(atomOpenMarkedElement).toExist()

        atomOpenMarkedPanel = atom.workspace.panelForItem(atomOpenMarkedElement)
        expect(atomOpenMarkedPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'atom-open-marked:toggle'
        expect(atomOpenMarkedPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.atom-open-marked')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'atom-open-marked:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        atomOpenMarkedElement = workspaceElement.querySelector('.atom-open-marked')
        expect(atomOpenMarkedElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'atom-open-marked:toggle'
        expect(atomOpenMarkedElement).not.toBeVisible()
