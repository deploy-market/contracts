import { PropsWithChildren } from "react";

const Wrapper = ({ children }: PropsWithChildren) => <div
  className="relative h-max flex flex-col items-center justify-center p-4 px-6 gap-x-6 gap-y-4 w-max max-w-2xl"
>
  <div className="absolute flex border-y opacity-10 w-screen h-full object-contain pointer-events-none" />
  <div className="absolute flex border-x opacity-10 w-full h-screen object-contain pointer-events-none" />
  <div className="flex relative h-max w-max flex-col gap-x-6 gap-y-4">
    {children}
  </div>
</div>

export default Wrapper
