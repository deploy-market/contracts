import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'

export default function Home() {
  return (
    <main className="flex flex-col gap-6 p-16">
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
