import App from 'resource:///com/github/Aylur/ags/app.js'
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js'

const outdir = '/home/erb/repos/nixos-config/home/modules/ags/config/build'

const main = await import(`file://${outdir}/main.js`)

export default main.default