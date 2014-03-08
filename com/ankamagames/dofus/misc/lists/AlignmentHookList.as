package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class AlignmentHookList extends Object
   {
      
      public function AlignmentHookList() {
         super();
      }
      
      public static const AlignmentRankUpdate:Hook = new Hook("AlignmentRankUpdate",false);
      
      public static const AlignmentSubAreasList:Hook = new Hook("AlignmentSubAreasList",false);
      
      public static const AlignmentAreaUpdate:Hook = new Hook("AlignmentAreaUpdate",false);
      
      public static const KohUpdate:Hook = new Hook("KohUpdate",false);
   }
}
