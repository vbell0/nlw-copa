import { Center, Spinner } from "native-base";

interface LoadingProps {

}

export function Loading(_props: LoadingProps) {
  return (
    <Center flex={1} bg="gray.900">
      <Spinner color="yellow.500" />
    </Center>
  )
}
