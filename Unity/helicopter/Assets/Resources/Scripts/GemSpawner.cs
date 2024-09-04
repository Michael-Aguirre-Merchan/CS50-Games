using UnityEngine;
using System.Collections;

public class GemSpawner : MonoBehaviour
{

    public GameObject[] prefabs;

    // Use this for initialization
    void Start()
    {

        StartCoroutine(SpawnGems());
    }

    // Update is called once per frame
    void Update()
    {

    }

    IEnumerator SpawnGems()
    {
        while (true)
        {

            int gemsThisRow = Random.Range(1, 4);

            for (int i = 0; i < gemsThisRow; i++)
            {
                Instantiate(prefabs[Random.Range(0, prefabs.Length)], new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);
            }

            yield return new WaitForSeconds(Random.Range(4, 7));
        }
    }
}
