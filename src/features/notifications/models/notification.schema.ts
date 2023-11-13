import { INotificationDocument } from '@notification/interfaces/notification.interface';
import mongoose, { model, Model, Schema } from 'mongoose';

const notificationSchema: Schema = new Schema({
  followerId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', index: true },
  followeeId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', index: true },
  createdAt: { type: Date, default: Date.now() }
});

const NotificationModel: Model<INotificationDocument> = model<INotificationDocument>('Notification', notificationSchema, 'Notification');
export { NotificationModel };
