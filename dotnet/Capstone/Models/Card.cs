using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Card
    {
        public int CardId { get; set; }

        public string CardFront { get; set; }
        public string CardBack { get; set; }
        public string CardImage { get; set; }
        public int UserId { get; set; }
        public int DeckId { get; set; }
        public int[] DeckIds { get; set; }
        public string[] Tags { get; set; }
        public bool IsCardPublic { get; set; }
    }
}
