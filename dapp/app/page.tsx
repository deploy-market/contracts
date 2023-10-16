"use client"
import Wrapper from '@/components/wrapper'
import { createOrbitDB } from '@orbitdb/core'
import IPFS from 'ipfs-core'
import Image from 'next/image'
import { useEffect } from "react"

export default function Home() {
  const connect = async () => {
    const ipfs = await IPFS.create()
    const orbitdb = await createOrbitDB({ ipfs })
    // Create / Open a database. Defaults to db type "events".
    const db = await orbitdb.open("hello")
    
    const address = db.address
    console.log(address)
    // "/orbitdb/zdpuAkstgbTVGHQmMi5TC84auhJ8rL5qoaNEtXo2d5PHXs2To"
    // The above address can be used on another peer to open the same database

    // Listen for updates from peers
    db.events.on("update", async (entry: any) => {
      console.log(entry)
      const all = await db.all()
      console.log(all)
    })

    // Add an entry
    const hash = await db.add("world")
    console.log(hash)

    // Query
    for await (const record of db.iterator()) {
      console.log(record)
    }
    
    await db.close()
    await orbitdb.stop()
  }

  useEffect(() => {
    connect()
  }, [])
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
