// make a function which takes a number, old min, old max, new min, new max and returns the new value
const mapValue = (value: number, oldMin: number, oldMax: number, newMin: number, newMax: number) => {
    return ((value - oldMin) * (newMax - newMin)) / (oldMax - oldMin) + newMin
}

export default mapValue