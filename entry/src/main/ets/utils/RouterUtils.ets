import { router } from "@kit.ArkUI";
import { BusinessError } from "@kit.BasicServicesKit";

export class RouterUtils {
  static routePageWithObjectParams(url: string, params: object): void {
    let options: router.RouterOptions = {
      url: url,
      params: params
    }
    try {
      router.pushUrl(options, router.RouterMode.Single);
    } catch (err) {
    }
  }

  static getParams(): object | undefined {
    let params: object | string = router.getParams();
    try {
      return params;
    } catch (err) {
      return undefined;
    }
  }
}