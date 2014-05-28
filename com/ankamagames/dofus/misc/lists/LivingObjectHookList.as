package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class LivingObjectHookList extends Object
   {
      
      public function LivingObjectHookList() {
         super();
      }
      
      public static const LivingObjectUpdate:Hook;
      
      public static const LivingObjectDissociate:Hook;
      
      public static const LivingObjectFeed:Hook;
      
      public static const LivingObjectAssociate:Hook;
      
      public static const MimicryObjectPreview:Hook;
      
      public static const MimicryObjectAssociated:Hook;
   }
}
