import { createContext, useContext, useState, type PropsWithChildren } from "react"

type Asscoiation = {
    key: string;
    sprite: string;
}

type KeyMapsContext = {
    associations: Array<Asscoiation>,
    setAssociations: React.Dispatch<React.SetStateAction<Asscoiation[]>>
}

const KeyMapsContext = createContext<KeyMapsContext>({
    associations: [],
    setAssociations: () => {}
})

const defaultHotkeys = [
  { key: 'd', sprite: 'dirt-texture.png' },
  { key: 'g', sprite: 'grass-texture.png' },
];

export function KeyMapsProvider({ children }: PropsWithChildren) {
    const [associations, setAssociations] = useState(JSON.parse(window.localStorage.getItem('_keymaps')) as Asscoiation[] ?? defaultHotkeys);

    return <KeyMapsContext.Provider value={{ associations, setAssociations }}>{children}</KeyMapsContext.Provider>
}

export function useKeyMapsContext() {
    const ctx = useContext(KeyMapsContext);

    if (!ctx) {
        throw new Error('Must use inside a key maps provider.')
    }
    return ctx;
}