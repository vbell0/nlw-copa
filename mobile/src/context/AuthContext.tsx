import { createContext, ReactNode, useState, useEffect } from "react";
import * as Google from "expo-auth-session/providers/google"
import * as AuthSession from "expo-auth-session";
import * as WebBrowser from "expo-web-browser";


WebBrowser.maybeCompleteAuthSession()

interface AuthProvaiderProps {
  children: ReactNode
}

interface userProps {
  name: string
  avatar_url: string
}

export interface authContextDataProps {
  isUserLogin: boolean
  user: userProps
  signin: () => Promise<void>
}

export const AuthContext = createContext({} as authContextDataProps)


export function AuthContextProvaider({ children }: AuthProvaiderProps) {
  const [user, setUser] = useState<userProps>({} as userProps)

  const [isUserLogin, setIsUserLogin] = useState(false);

  const [request, response, prompAsync] = Google.useAuthRequest({
    clientId: "420109662140-4tr94s5fncr5vlt4pj3332q3votrma4a.apps.googleusercontent.com",
    redirectUri: AuthSession.makeRedirectUri({ useProxy: true }),
    scopes: ["profile", "email"]
  })


  async function signin() {
    try {
      setIsUserLogin(true)
      await prompAsync()
    } catch (error) {
      console.log(error)
      throw error
    } finally {
      setIsUserLogin(false)
    }
  }

  async function signin_google(accessToken: string) {
    console.log("accesstoken => ", accessToken)
  }

  useEffect(() => {
    if (response?.type === "success" && response.authentication.accessToken) {
      signin_google(response.authentication.accessToken)
    }
  }, [response])

  return (
    <AuthContext.Provider value={{
      signin,
      isUserLogin,
      user
    }}>
      {children}
    </AuthContext.Provider>
  )
}
