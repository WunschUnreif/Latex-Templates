colors = {
    'blue'      : [  0, 122, 255],
    'brown'     : [162, 132,  94],
    'cyan'      : [ 85, 190, 240],
    'gray'      : [142, 142, 147],
    'green'     : [ 40, 205,  65],
    'indigo'    : [ 88,  86, 214],
    'mint'      : [  0, 199, 190],
    'orange'    : [255, 149,   0],
    'pink'      : [255,  45, 85],
    'purple'    : [175,  82, 222],
    'red'       : [255,  59, 48],
    'teal'      : [ 89, 173, 196],
    'yellow'    : [255, 204,   0],
}

variedColors = {}

function getHex(rgb) {
    let hexes = rgb.map(v => {
        let hex = v.toString(16)
        if(hex.length < 2) {
            hex = '0' + hex
        }
        return hex
    })
    return `${hexes[0]}${hexes[1]}${hexes[2]}`
}

function mixed(color, bg, ratio) {
    return [
        Math.round(color[0] * ratio + bg[0] * (1 - ratio)),
        Math.round(color[1] * ratio + bg[1] * (1 - ratio)),
        Math.round(color[2] * ratio + bg[2] * (1 - ratio)),
    ]
}

function genVariations() {
    for(let name in colors) {
        let color = colors[name]
        variedColors[`${name}-base`] = getHex(color)
        for(let grade = 1; grade <= 5; grade += 1) {
            variedColors[`${name}-lighten-${grade}`] = getHex(mixed(color, [255, 255, 255], 1 - 0.18 * grade))
        }
        for(let grade = 1; grade <= 5; grade += 1) {
            variedColors[`${name}-darken-${grade}`] = getHex(mixed(color, [0, 0, 0], 1 - 0.1 * grade))
        }
    }
}

function genDefs() {
    for(let name in variedColors) {
        console.log(`\\definecolor{${name}}{HTML}{${variedColors[name]}}`)
    }
}

function genDemo() {
    console.log('\\begin{testcolors}[html]')
    for(let name in variedColors) {
        console.log(`\\testcolor{${name}}`)
    }
    console.log('\\end{testcolors}')
}

genVariations()
genDefs()
// genDemo()
