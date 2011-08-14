package fi.validi.network {
	import fi.validi.network.model.INetObject;
	import fi.validi.network.model.INetwork;
	/**
	 * @author jiv
	 */
	public class VectorOperations {
		public static function difference(substractFrom : Vector.<INetObject>, substracted : Vector.<INetObject>) : Vector.<INetObject> {
			if(substractFrom.length == 0) {
				trace("Error: Vector 'substractFrom' is empty.");
				return substractFrom;
			}
			else if (substracted.length == 0) {
				trace("Error: Vector 'substracted' is empty.");
				return substractFrom;
			}
			substractFrom.sort(compare);
			substracted.sort(compare);
			var difference : Vector.<INetObject> = new Vector.<INetObject>();
			var i : uint = 0;
			var j : uint = 0;
			
			while(i < substractFrom.length) {
				if (substractFrom[i] == substracted[j]) {
					i++;
					j++;
				}
				else if (substractFrom[i].ID < substracted[j]) {
					difference.push(substractFrom[i]);
					i++;
				}
				else {
					j++;
				}
				if (j >= substracted.length) {
					difference = difference.concat(substractFrom.slice(i));
					break;
				}
			}
			
			return difference;
		}
		
		public static function intersection(vector1 : Vector.<INetObject>, vector2 : Vector.<INetObject>) : Vector.<INetObject> {
			vector1.sort(compare);
			vector2.sort(compare);
			var intersection : Vector.<INetObject> = new Vector.<INetObject>();
			var i : uint = 0;
			var j : uint = 0;
			
			while(i < vector1.length || j < vector2.length) {
				if (vector1[i] == vector2[j]) {
					intersection.push(vector1[i]);					
					i++;
					j++;
				}
				else if (vector1[i].ID < vector2[j]) {
					i++;
				}
				else {
					j++;
				}
			}
			
			return intersection;
		}

		public static function compare(x : INetObject, y : INetObject) : Number {
			if(x.ID < y.ID) return -1;
			else if(x.ID > y.ID) return 1;
			else return 0;
		}
		
		public static function isEqual(vector1 : Vector.<INetObject>, vector2 : Vector.<INetObject>) : Boolean {
			if(!vector2 && !vector1) {
				return true;      
			}
			if(!vector2 || !vector1) {  
				return false;      
			}
			if(vector1.length != vector2.length) {   
				return false;
			}
			for(var i:uint = 0; i < vector1.length; i++) {              
				if(vector1[i] != vector2[i])  
				return false; 
			}          
			return true; 
		}
	}
}
