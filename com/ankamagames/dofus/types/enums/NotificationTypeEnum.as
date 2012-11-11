package com.ankamagames.dofus.types.enums
{

    public class NotificationTypeEnum extends Object
    {
        public static const TUTORIAL:uint = 0;
        public static const ERROR:uint = 1;
        public static const INVITATION:uint = 2;
        public static const PRIORITY_INVITATION:uint = 3;
        public static const INFORMATION:uint = 4;
        public static const NOTIFICATION_PRIORITY:Array = [NotificationTypeEnum.ERROR, NotificationTypeEnum.PRIORITY_INVITATION, NotificationTypeEnum.INVITATION, NotificationTypeEnum.INFORMATION, NotificationTypeEnum.TUTORIAL];

        public function NotificationTypeEnum()
        {
            return;
        }// end function

    }
}
