import Wrapper from '@/components/wrapper'

import Image from 'next/image'

export default function Home() {
  return (
      <main className="flex items-center justify-center h-screen w-full overflow-hidden text-gray-400 p-2">
        <Wrapper>
          <div className="brightness-[1.4]">
            <Image
              src="/deploy.market.color.svg"
              width={211}
              height={30}
              alt="deploy.market logo"
            />
          </div>
          <p>You don't <i>have to</i> do it by yourself.</p>
        </Wrapper>
      </main>
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
