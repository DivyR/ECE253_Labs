int LIST[] = {10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33};

int swap(int *ptr)
{
    // no swap needed
    if (*ptr <= *(ptr + 1))
        return 0;
    // swap them
    int temp = *ptr;
    *ptr = *(ptr + 1);
    *(ptr + 1) = temp;
    return 1;
}

int main(int argc, char const *argv[])
{
    // bubble sort
    int *R0 = &LIST;
    int N = *R0;
    while (1) // loopi
    {
        N -= 1;
        if (N <= 0)
            break;

        int j = 0;
        int flag = 0;
        while (j != N) // loopj
        {
            R0 += 1;
            flag += swap(R0);
            j -= 1;
        }
        // check if zero swaps occured
        if (!flag)
            break;
        // reset to first
        R0 = &LIST;
    }
    int R0 = LIST[1]; // lowest element after the cardinality integer
    return 0;
}
