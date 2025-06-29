import { useRef, useState, type KeyboardEventHandler } from "react";

type Props = {
  width: number;
  height: number;
};

export function MapGrid({ width, height }: Props) {
  const cells = new Array(width * height).fill(0);
  return (
    <div
      className="grid gap-2 border border-black rounded p-4"
      style={{
        gridTemplateColumns: `repeat(${width}, 1fr)`,
        gridTemplateRows: `repeat(${height}, 1fr)`,
      }}
    >
      {cells.map((_, idx) => {
        const row = Math.floor(idx / width);
        const col = idx % width;
        return <MapGridCell key={`${row}-${col}`} row={row} col={col} idx={idx} />;
      })}
    </div>
  );
}

function MapGridCell({ row, col, idx }: { row: number; col: number, idx: number }) {
  const ref = useRef<HTMLDivElement>(null);
  const [value, setValue] = useState('-');
  const [isHovered, setIsHovered] = useState(false);

  const handleKeyPress: KeyboardEventHandler<HTMLDivElement> = (event) => {
    if (isHovered) {
      setValue(event.key)
    }
  }

  return (
    <div
      ref={ref}
      tabIndex={idx}
      data-coords={`${row}-${col}`}
      className="size-full hover:bg-gray-200 text-center border border-gray-300 flex items-center justify-center text-sm aspect-square"
      onMouseEnter={() => {
        setIsHovered(true); 
        ref.current.focus()
      }}
      onMouseLeave={() => {
        setIsHovered(false)
      }}
      onKeyDown={handleKeyPress}
    >
      {value}
    </div>
  );
}
