using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z2
{
  class Program
  {
    static void Main(string[] args)
    {

    }

    class Node<T> : IEnumerable<T> where T : IComparable<T>
    {
      public T data { get; set; }
      public Node<T> left { get; set; }
      public Node<T> right { get; set; }

      public Node(T value)
      {
        this.data = value;
        this.left = null;
        this.right = null;
      }

      public void insert(T value)
      {
        T val = this.data;

        if (value.CompareTo(val) <= 0)
        {
          if (this.left == null)
            this.left = new Node<T>(value);
          else
            this.left.insert(value);
        }
        else
        {
          if (this.right == null)
            this.right = new Node<T>(value);
          else
            this.right.insert(value);
        }
      }

      public IEnumerator<T> GetEnumerator()
      {
        throw new NotImplementedException();
      }


      //bfs
      //IEnumerator<T> IEnumerable<T>.GetEnumerator()
      //{
      //  Queue<Node<T>> q = new Queue<Node<T>>();
      //  q.Enqueue(this);
      //  while (q.Count > 0)
      //  {
      //    Node<T> node = q.Dequeue();
      //    yield return node.data;
      //    if (node.left != null)
      //    {
      //      q.Enqueue(node.left);
      //    }
      //    if (node.right != null)
      //    {
      //      q.Enqueue(node.right);
      //    }
      //  }
      //}

      //dfs
      IEnumerator<T> IEnumerable<T>.GetEnumerator()
      {
        if (this.left != null)
        {
          foreach (T item in this.left)
          {
            yield return item;
          }
        }

        yield return this.data;

        if (this.right != null)
        {
          foreach (T item in this.right)
          {
            yield return item;
          }
        }
      }

      IEnumerator IEnumerable.GetEnumerator()
      {
        throw new NotImplementedException();
      }
    }

    class TreeEnumeratorBFS<T> : IEnumerator<T> where T : IComparable<T>
    {
      private Node<T> _node = null;
      private T _value = default(T);
      private Queue<T> _q;

      public TreeEnumeratorBFS(Node<T> node)
      {
        this._node = node;
      }

      private void bfs(Node<T> root, Queue<T> order)
      {
        Queue<Node<T>> q = new Queue<Node<T>>();
        q.Enqueue(root);

        while (q.Count > 0)
        {
          Node<T> node = q.Dequeue();
          order.Enqueue(node.data);

          if (node.left != null)
            q.Enqueue(node.left);

          if (node.right != null)
            q.Enqueue(node.right);
        }
      }

      public T Current
      {
        get
        {
          if (this._q == null)
            throw new InvalidOperationException("Enumerator not initialized");

          return this._value;
        }
      }

      object IEnumerator.Current
      {
        get
        {
          if (this._q == null)
            throw new InvalidOperationException("Enumerator not initialized");

          return this._value;
        }
      }

      public void Dispose()
      {
        throw new NotImplementedException();
      }

      public bool MoveNext()
      {
        if (this._q == null)
        {
          this._q = new Queue<T>();
          bfs(this._node, this._q);
        }

        if (this._q.Count > 0)
        {
          this._value = this._q.Dequeue();
          return true;
        }

        return false;
      }

      public void Reset()
      {
        throw new NotImplementedException();
      }
    }

    class TreeEnumeratorDFS<T> : IEnumerator<T> where T : IComparable<T>
    {
      private Node<T> _node = null;
      private T _value = default(T);
      private Queue<T> _q;

      public TreeEnumeratorDFS(Node<T> node)
      {
        this._node = node;
      }

      private void dfs(Node<T> root, Queue<T> order)
      {
        order.Enqueue(root.data);

        if (root.left != null)
          dfs(root.left, order);

        if (root.right != null)
          dfs(root.right, order);

      }

      public T Current
      {
        get
        {
          if (this._q == null)
            throw new InvalidOperationException("Enumerator not initialized");

          return this._value;
        }
      }

      object IEnumerator.Current
      {
        get
        {
          if (this._q == null)
            throw new InvalidOperationException("Enumerator not initialized");

          return this._value;
        }
      }

      public void Dispose()
      {
        throw new NotImplementedException();
      }

      public bool MoveNext()
      {
        if (this._q == null)
        {
          this._q = new Queue<T>();
          dfs(this._node, this._q);
        }

        if (this._q.Count > 0)
        {
          this._value = this._q.Dequeue();
          return true;
        }

        return false;
      }

      public void Reset()
      {
        throw new NotImplementedException();
      }
    }

  }
}
