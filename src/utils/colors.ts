// make it in typescript
const getRandomColor = () => {
    return `#${Math.floor(Math.random() * 16777215).toString(16)}`
}

export default getRandomColor