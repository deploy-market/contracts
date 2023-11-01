"use client"
import Wrapper from '@/components/wrapper'

import Image from 'next/image'

export default function Home() {
  
  return (
      <div className="flex flex-col items-center justify-start h-screen w-full overflow-hidden text-gray-400 py-6">
        <Wrapper>
          <header className="flex flex-row justify-between items-center gap-6">
            <div className="brightness-[1.4]">
              <Image
                src="/deploy.market.color.svg"
                width={211}
                height={30}
                alt="deploy.market logo"
              />
            </div>
            <nav className="flex flex-row justify-between items-center gap-3">
              <button className="text-white">Deploy</button>
              <button>Transact</button>
            </nav>
          </header>
          {/* <OrbitConnector /> */}
        </Wrapper>
      </div>
  )
}
      /*   </Wrapper>
      <Header />
      <section className="flex flex-row gap-2">
        <Badge>deployment</Badge>
        <Badge variant="secondary">transactions</Badge>
        <Badge variant="secondary">other help</Badge>
      </section>
      <section className="w-full grid grid-flow-col gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Deployer</CardTitle>
            <CardDescription>I deploy contracts</CardDescription>
          </CardHeader>
          <CardContent>
            <p>Hello, I can deploy your contract code for you for an 0.1 ETH commission</p>
          </CardContent>
          <CardFooter className="flex justify-end gap-4">
            <small>Gas + 0.1 ETH</small> <Button>Deploy</Button>
          </CardFooter>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Deployer</CardTitle>
            <CardDescription>I deploy contracts</CardDescription>
          </CardHeader>
          <CardContent>
            <p>Hello, I can deploy your contract code for you for an 0.12 ETH commission</p>
          </CardContent>
          <CardFooter className="flex justify-end gap-4">
            <small>Gas + 0.12 ETH</small> <Button>Deploy</Button>
          </CardFooter>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Deployer</CardTitle>
            <CardDescription>I deploy contracts</CardDescription>
          </CardHeader>
          <CardContent>
            <p>Hello, I can deploy your contract code for you for an 0.12 ETH commission</p>
          </CardContent>
          <CardFooter className="flex justify-end gap-4">
            <small>Gas + 0.12 ETH</small> <Button>Deploy</Button>
          </CardFooter>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Deployer</CardTitle>
            <CardDescription>I deploy contracts</CardDescription>
          </CardHeader>
          <CardContent>
            <p>Hello, I can deploy your contract code for you for an 0.12 ETH commission</p>
          </CardContent>
          <CardFooter className="flex justify-end gap-4">
            <small>Gas + 0.12 ETH</small> <Button>Deploy</Button>
          </CardFooter>
        </Card>
      </section>
    </main>
  )
}
 */
