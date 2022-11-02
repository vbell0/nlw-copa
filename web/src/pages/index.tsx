import AppPreviewImg from "../assets/app_preview.png"
import Logo from "../assets/logo.svg"
import UserAvatarExemple from "../assets/avatares.png"
import IconCheck from "../assets/icon_check.svg"
import Image from "next/image"
import { api } from "../lib/axies"
import { FormEvent, useState } from "react"

interface HomeProps {
  pool_count: number,
  gueess_count: number,
  user_count: number,
}

export default function Home(props: HomeProps) {
  const [pool_title, set_pool_title] = useState("")

  async function create_pool(event: FormEvent) {
    event.preventDefault()
    try {
      console.log(pool_title)
      const response = await api.post("/pools", {
        title: pool_title,
      }) 

      const { code } = response.data

      await navigator.clipboard.writeText(code)
      set_pool_title("")
      alert("Bolao criado com sucesso, o codigo foi transferido para a area de transferencia!")
    } catch (error: any) {
      alert("Error Falha ao criar o bolao, tent novamente!")
    }
  }

  return (
    <div className="max-w-[1124px] h-screen mx-auto grid grid-cols-2 items-center gap-28">
      <main>
        <Image src={Logo} alt="NLW COPA" />

        <h1 className="mt-14 text-white text-5xl font-bold leading-tight">Crie seu próprio bolão da copa e compartilhe entre amigos!</h1>

        <div className="mt-10 flex items-center gap-2">
          <Image src={UserAvatarExemple} alt="" />
          <strong className="text-gray-100 text-xl">
            <span className="text-ignite-500">+{props.user_count}</span> pessoas ja estao usando.
          </strong>
        </div>

        <form 
          onSubmit={create_pool} 
          className="mt-10 flex gap-2"
        >
          <input
            onChange={event => set_pool_title(event.target.value)}
            className="flex-1 text-gray-100 px-6 py-4 rounded border bg-gray-800 border-gray-600 text-sm"
            type="text"
            required
            placeholder="Qual nome do seu Boloa?"
            value={pool_title}
          />
          <button
            className="bg-yellow-500 px-6 py-4 rounded text-gray-900 font-bold text-sm uppercase hover:bg-yellow-700"
            type="submit"
          > Criar meu Boloa</button>
        </form>

        <p className="text-gray-300 mt-4 text-sm leading-relaxed">
          Após criar seu bolão, você receberá um código único que poderá usar para convidar outras pessoas 🚀
        </p>

        <div className="mt-10 pt-10 border-t border-gray-600 flex justify-between items-center text-gray-100">
          <div className="flex items-center gap-4">
            <Image src={IconCheck} alt="" />
            <div className="flex flex-col">
              <span className="font-bold text-2xl">+{props.pool_count}</span>
              <span>Bolaes criados</span>
            </div>
          </div>

          <div className="w-px h-14 bg-gray-600" />

          <div className="flex items-center gap-4">
            <Image src={IconCheck} alt="" />
            <div className="flex flex-col">
              <span className="font-bold text-2xl">+{props.gueess_count}</span>
              <span>Palpites criados</span>
            </div>
          </div>
        </div>
      </main>
      <Image
        src={AppPreviewImg}
        alt="Dois celulareas exibindo uma previea do app mobile"
        quality={100}
      />
    </div>
  )
}

export const getServerSideProps = async () => {
  const [
    pool_count_response, 
    guess_count_response,
    user_count_response,
  ] = await Promise.all([
    api.get("/pools/count"),
    api.get("/guesses/count"),
    api.get("/users/count"),
  ])

  return {
    props: {
      pool_count: pool_count_response.data.count,
      gueess_count: guess_count_response.data.count,
      user_count: user_count_response.data.count,
    }
  }
}
