"use client"
import Header from '@/components/header'
import Wrapper from '@/components/wrapper'


export default function Home() {
  
  return (
      <div className="flex flex-col items-center justify-start h-screen w-full overflow-hidden text-gray-400 py-6">
        <Wrapper>
          <Header />
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
