package com.ankamagames.jerakine.replay
{

    public class LogTypeEnum extends Object
    {
        public static const REGISTER_CLASS:uint = 0;
        public static const NETWORK_IN:uint = 1;
        public static const NETWORK_OUT:uint = 2;
        public static const MOUSE:uint = 3;
        public static const ACTION:uint = 4;
        public static const TEXT:uint = 5;
        public static const EXCEPTION:uint = 6;
        public static const MESSAGE:uint = 7;
        public static const REGISTER_STRING:uint = 8;
        public static const KEYBOARD_INPUT:uint = 9;
        public static const SHORTCUT:uint = 10;
        public static const COMPUTER_INFO:uint = 11;
        public static const PROCESS_INFO:uint = 12;
        public static const OBJECTS_INFO:uint = 14;
        public static const FPS:uint = 15;
        public static const RAM:uint = 16;

        public function LogTypeEnum()
        {
            return;
        }// end function

    }
}
