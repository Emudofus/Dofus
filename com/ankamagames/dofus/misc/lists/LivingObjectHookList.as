package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class LivingObjectHookList extends Object
   {
      
      public function LivingObjectHookList() {
         super();
      }
      
      public static const LivingObjectUpdate:Hook = new Hook("LivingObjectUpdate",false);
      
      public static const LivingObjectDissociate:Hook = new Hook("LivingObjectDissociate",false);
      
      public static const LivingObjectFeed:Hook = new Hook("LivingObjectFeed",false);
      
      public static const LivingObjectAssociate:Hook = new Hook("LivingObjectAssociate",false);
      
      public static const MimicryObjectPreview:Hook = new Hook("MimicryObjectPreview",false);
      
      public static const MimicryObjectAssociated:Hook = new Hook("MimicryObjectAssociated",false);
   }
}
