import { prompt } from '@kit.ArkUI';

export class PromptUtils {
  static showToast(message: string, duration: number = 3000): void {
    try {

      prompt.showToast({
        message: message,
        duration: duration
      });
    } catch (error) {
      console.error('Toast not shown:', error);
    }
  }
}
