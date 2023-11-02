import Image from "next/image"
import GridDiv from "./griddiv"

const Header = () => {
  return <header className="flex flex-row justify-between items-center gap-6">
    <div  className="brightness-[1.4]">
      <Image src="/deploy.market.color.svg" width={211} height={30} alt="deploy.market logo" />
    </div>
      <GridDiv>
        <nav className="flex flex-row justify-between items-center gap-3">
          <button className="text-white">Deploy</button>
          <button>Transact</button>
        </nav>
      </GridDiv>
      <GridDiv>
        <nav className="flex flex-row justify-between items-center gap-3">
          <button className="text-white">Customer</button>
          <button>Provider</button>
        </nav>
      </GridDiv>
  </header>
}

export default Header
