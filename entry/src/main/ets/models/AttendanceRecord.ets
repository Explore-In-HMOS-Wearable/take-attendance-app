// AttendanceRecord.ts
export class AttendanceRecord {
  date: string;
  firstRecord: string;
  lastRecord: string;
  status: 'waiting' | 'pending' | 'approved' | 'late';

  constructor(
    date: string = 'Today',
    firstRecord: string = '--:--:--',
    lastRecord: string = '--:--:--',
    status: 'waiting' | 'pending' | 'approved' | 'late' = 'waiting'
  ) {
    this.date = date;
    this.firstRecord = firstRecord;
    this.lastRecord = lastRecord;
    this.status = status;
  }

  static getCurrentTime(): string {
    const now: Date = new Date();
    return `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes()
      .toString()
      .padStart(2, '0')}:${now.getSeconds().toString().padStart(2, '0')}`;
  }


  recordFirstEntry(): void {
    if (this.firstRecord === '--:--:--') {
      this.firstRecord = AttendanceRecord.getCurrentTime();

      const now: Date = new Date();
      // 08:00 control
      if (now.getHours() > 8 || (now.getHours() === 8 && now.getMinutes() > 0)) {
        this.status = 'late';
      } else {
        this.status = 'approved';
      }
    }
  }


  recordLastEntry(): void {
    if (this.firstRecord !== '--:--:--' && this.lastRecord === '--:--:--') {
      this.lastRecord = AttendanceRecord.getCurrentTime();
      this.status = 'approved';
    }
  }

  isComplete(): boolean {
    return this.firstRecord !== '--:--:--' && this.lastRecord !== '--:--:--';
  }
}