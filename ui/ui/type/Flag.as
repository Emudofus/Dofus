package ui.type
{
   import flash.geom.Point;
   
   public class Flag extends Object
   {
      
      public function Flag(id:String, x:int, y:int, legend:String, color:int = -1) {
         super();
         this.id = id;
         this.position = new Point(x,y);
         this.legend = legend;
         this.color = color;
      }
      
      public var id:String;
      
      public var position:Point;
      
      public var legend:String;
      
      public var color:uint;
   }
}
