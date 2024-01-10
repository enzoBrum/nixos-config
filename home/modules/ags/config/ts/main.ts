import { Variable } from 'resource:///com/github/Aylur/ags/variable.js';
import { Widget } from 'resource:///com/github/Aylur/ags/widget.js';
import { Workspaces, focusedTitle } from './workspaces.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const time = new Variable('', {
    poll: [1000, 'date'],
});

const left_bar = (monitor: number, two_monitors: boolean) => Widget.Box({
    children: [
        Workspaces(two_monitors ? 1 - monitor : monitor),
        focusedTitle()
    ]
});

const Bar = (monitor: number, two_monitors: boolean = true) => Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: left_bar(monitor, two_monitors),
        center_widget: Widget.Label({
            hpack: 'center',
            binds: [['label', time]],
        }),
    })
});


const monitors = JSON.parse(exec("hyprctl monitors -j"));
let windows_array;

if (monitors.length === 2)
    windows_array = [Bar(0), Bar(1)];
else
    windows_array = [Bar(0, false)]

export default {
    windows: windows_array
}
