import { Center, Text, Icon } from "native-base";
import { Fontisto } from "@expo/vector-icons";
import { userAuth } from "../hook/userAuth";

import Logo from "../assets/logo.svg"
import { Button } from "../components/Button";

export function Signin() {
  const { signin, user } = userAuth()
  console.log("Logado =>", user)
  return (
    <Center flex={1} bgColor="gray.900" p={8}>
      <Logo width={212} height={40} />
      <Button
        title="ENTRA COM GOOGLE"
        type="SECONDARY"
        leftIcon={<Icon as={Fontisto} name="google" color="white" size="md" />}
        mt={12}
        onPress={signin}
      />

      <Text
        color="white"
        textAlign="center"
        mt={4}
      >
        Não utilizamos nenhuma informação além {"\n"} do seu e-mail para criação de sua conta.
      </Text>

    </Center>
  )
}
