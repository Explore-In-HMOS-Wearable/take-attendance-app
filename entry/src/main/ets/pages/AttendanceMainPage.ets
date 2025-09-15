// AttendanceMainPage.ts
import { AttendanceCard } from "../components/AttendanceCard";
import { AttendanceRecord } from "../models/AttendanceRecord";
import { UIContext, ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, ComponentContent, } from '@kit.ArkUI';
import { abilityAccessCtrl, common, Permissions } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { RouterUtils } from "../utils/RouterUtils";

const permissions: Array<Permissions> =
  ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.VIBRATE'];

function reqPermissionsFromUser(permissions: Array<Permissions>, context: common.UIAbilityContext): void {
  let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
  atManager.requestPermissionsFromUser(context, permissions).then((data) => {
    let grantStatus: Array<number> = data.authResults;
    let length: number = grantStatus.length;
    for (let i = 0; i < length; i++) {
      if (grantStatus[i] === 0) {
        // If the user grants the permission, the application continues the operation.
      } else {
        return;
      }
    }
    // Authorization is successful.
  }).catch((err: BusinessError) => {
    console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
  })
}

@Entry
@Component
export struct AttendanceMainPage {
  @State attendanceRecords: AttendanceRecord[] = [
    new AttendanceRecord('2025-8-26', '08:08:17', '17:00:20', 'approved'),
    new AttendanceRecord('Today', '--:--:--', '--:--:--', 'waiting'),
  ];

  aboutToAppear() {

    const context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
    reqPermissionsFromUser(permissions, context);

  }

  build() {
    Column() {
      Text('Attendance Records')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 25, bottom: 20 })

      ArcList() {
        ForEach(this.attendanceRecords, (record: AttendanceRecord, index: number) => {
          ArcListItem() {
            AttendanceCard({ record: record })
              .onClick(() => {
                RouterUtils.routePageWithObjectParams('pages/AttendanceDetailPage',
                  record
                );
              })
              .padding(5)
          }
        }, (record: AttendanceRecord) => record.date + record.firstRecord + record.lastRecord)
      }
      .height('70%')
      .width('100%')
      .alignSelf(ItemAlign.Center)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }
}