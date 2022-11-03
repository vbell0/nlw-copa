import { NativeBaseProvider, StatusBar } from 'native-base';
import { useFonts, Roboto_400Regular, Roboto_500Medium, Roboto_700Bold } from "@expo-google-fonts/roboto"

import { THEME } from "./src/styles/themes"


import { Loading } from "./src/components/Loading"
import { Signin } from './src/screens/Signin';
import { Pools } from './src/screens/Pools';
import { AuthContextProvaider } from './src/context/AuthContext';
import { New } from './src/screens/New';
import { Find } from './src/screens/Find';

export default function App() {
  const [fontsLoaded] = useFonts({
    Roboto_400Regular, Roboto_500Medium, Roboto_700Bold
  });

  return (
    <NativeBaseProvider theme={THEME}>
      <AuthContextProvaider>
        <StatusBar
          barStyle='light-content'
          backgroundColor="transparent"
          translucent
        />
        {fontsLoaded ? <Pools /> : <Loading />}
      </AuthContextProvaider>
    </NativeBaseProvider>
  );
};
