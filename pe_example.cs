using System;
using System.Net;
using System.Net.NetworkInformation;

class Program
{
    static void Main()
    {
        string EncodedIP = "0x1.65793"; // 1.1.1.1

        Console.WriteLine("Pinging IP address: " + EncodedIP);

        Ping pingSender = new Ping();
        PingReply reply = pingSender.Send(EncodedIP);

        if (reply.Status == IPStatus.Success)
        {
            Console.WriteLine("Ping successful. Round-trip time: " + reply.RoundtripTime + " ms");
        }
        else
        {
            Console.WriteLine("Ping failed. Status: " + reply.Status.ToString());
        }
    }
}
