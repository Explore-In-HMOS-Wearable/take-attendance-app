import { AttendanceRecord } from '../models/AttendanceRecord';
@Component
export struct AttendanceCard {
  private record: AttendanceRecord = new AttendanceRecord();
  setRecord(record: AttendanceRecord): AttendanceCard {
    this.record = record;
    return this;
  }

  build() {
    Column() {
      Row(){
        Text('Date: ')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 5, right:10 })
          .fontColor(Color.Black)
        Text(this.record.date)
          .fontSize(12)
          .fontColor(Color.Gray)
      }

      Row() {
        Column() {
          Text('First record')
            .fontSize(12)
            .opacity(0.7)
          Text(this.record.firstRecord)
            .fontSize(14)
            .fontColor(this.record.firstRecord !== '--:--:--' ? '#000' : '#999')
        }
        .width('50%')

        Column() {
          Text('Last record')
            .fontSize(12)
            .opacity(0.7)
          Text(this.record.lastRecord)
            .fontSize(14)
            .fontColor(this.record.lastRecord !== '--:--:--' ? '#000' : '#999')
        }
        .width('50%')
      }
      .width('100%')
      .margin({ bottom: 10 })

      if (this.record.status === 'approved') {
        Text('Approved')
          .fontSize(12)
          .fontColor('#0A0')
      } else if (this.record.status === 'late') {
        Text('You are late')
          .fontSize(12)
          .fontColor('#F00')
      } else if (this.record.status === 'pending') {
        Text('pending')
          .fontSize(12)
          .fontColor('#FA0')
      } else if (this.record.status === 'waiting') {
        Text('Waiting for attendance')
          .fontSize(12)
          .fontColor('#999')
      }
    }
    .padding(15)
    .width('90%')
    .height('70%')
    .backgroundColor('#FFF')
    .borderRadius(15)
    .shadow({
      radius: 3,
      color: '#00000022',
      offsetX: 1,
      offsetY: 1
    })
  }
}
