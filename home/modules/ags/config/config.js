import { Workspaces, focusedTitle } from "./src/workspaces.js";

const date = Variable("", {
  poll: [1000, "date '+%H:%M %d/%m'"],
});

const left_bar = (monitor, two_monitors = false) =>
  Widget.Box({
    children: [
      Workspaces(two_monitors ? 1 - monitor : monitor),
      focusedTitle(),
    ],
  });

/**
 * @param {number} monitor
 * */
const create_bar = (monitor, two_monitors = false) =>
  Widget.Window({
    name: `bar-${monitor}`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: left_bar(monitor, two_monitors),
      center_widget: Widget.Label({ label: date.bind() }),
    }),
  });

const num_monitors = JSON.parse(Utils.exec("hyprctl monitors -j")).length;

let windows = [create_bar(0)];
if (num_monitors === 2) windows.push(create_bar(1));

App.config({
  windows: windows,
  style: App.configDir + "/style.scss",
});
