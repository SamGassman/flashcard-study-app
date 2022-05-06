using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Deck
    {
        public int DeckId { get; set; }
        public int UserId { get; set; }
        public string DeckName { get; set; }
        public string DeckDescription { get; set; }
        public bool isDeckPublic { get; set; }
        public int SubId { get; set; }
    }
}
