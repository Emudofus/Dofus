package com.ankamagames.berilia.utils
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class BeriliaHookList extends Object
   {
      
      public function BeriliaHookList() {
         super();
      }
      
      public static const MouseClick:Hook;
      
      public static const MouseMiddleClick:Hook;
      
      public static const MouseShiftClick:Hook;
      
      public static const MouseCtrlClick:Hook;
      
      public static const MouseAltClick:Hook;
      
      public static const MouseCtrlDoubleClick:Hook;
      
      public static const MouseAltDoubleClick:Hook;
      
      public static const PostMouseClick:Hook;
      
      public static const KeyUp:Hook;
      
      public static const FocusChange:Hook;
      
      public static const DropStart:Hook;
      
      public static const DropEnd:Hook;
      
      public static const KeyboardShortcut:Hook;
      
      public static const ShortcutUpdate:Hook;
      
      public static const TextureLoadFailed:Hook;
      
      public static const SlotDropedOnBerilia:Hook;
      
      public static const SlotDropedOnWorld:Hook;
      
      public static const SlotDropedNorBeriliaNorWorld:Hook;
      
      public static const UiLoaded:Hook;
      
      public static const ChatHyperlink:Hook;
      
      public static const ChatRollOverLink:Hook;
      
      public static const UiUnloading:Hook;
      
      public static const UiUnloaded:Hook;
      
      public static const WindowResize:Hook;
   }
}
