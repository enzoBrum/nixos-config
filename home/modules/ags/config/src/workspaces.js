const Hyprland = await Service.import("hyprland");

export const focusedTitle = () =>
  Widget.Label({
    label: Hyprland.active.client.bind("title"),
    visible: Hyprland.active.client.bind("address").transform((addr) => !!addr),
  });

const dispatch = (ws) => Hyprland.sendMessage(`dispatch workspace ${ws}`);

const Workspace = (monitor, i) => {
  const w = Widget.Button({
    attribute: i,
    child: Widget.Label(""),
    on_clicked: () => dispatch(monitor * 10 + i),
    class_name: "inactive",
  })
    .hook(
      Hyprland,
      (self, name) => {
        self.class_name =
          parseInt(name) === self.attribute ? "focused" : self.class_name;
      },
      "workspace-added"
    )
    .hook(
      Hyprland,
      (self, name) => {
        self.class_name =
          parseInt(name) === self.attribute ? "inactive" : self.class_name;
      },
      "workspace-removed"
    );

  Hyprland.active.workspace.bind("id").transform((id) => {
    if (id === w.attribute) {
      w.class_name = "focused";
      w.child.label = "";
    } else if (w.class_name === "focused") {
      w.class_name = "active";
      w.child.label = "";
    }
  });

  return w;
};

export const Workspaces = (monitor) =>
  Widget.EventBox({
    on_scroll_up: () => dispatch("+1"),
    on_scroll_down: () => dispatch("-1"),
    child: Widget.Box({
      children: Array.from({ length: 10 }, (_, i) => i + 1).map((i) =>
        Workspace(monitor, i)
      ),
    }),
    class_name: "workspaces",
  });
